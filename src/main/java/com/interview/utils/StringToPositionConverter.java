package com.interview.utils;

import org.springframework.core.convert.converter.Converter;
import com.interview.enums.Position;

public class StringToPositionConverter implements Converter<String, Position> {

    /**
     * Converts a string representation of a position to a Position object.
     * 
     * @param source the string representation of the position
     * @return the Position object corresponding to the given string, or null if the
     *         string is not a valid position
     */
    @SuppressWarnings("null")
    @Override
    public Position convert(String source) {
        try {
            return Position.valueOf(source.toUpperCase());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}